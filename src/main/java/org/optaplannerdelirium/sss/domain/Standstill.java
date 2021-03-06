/*
 * Copyright 2012 JBoss Inc
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.optaplannerdelirium.sss.domain;

import org.optaplanner.core.api.domain.entity.PlanningEntity;
import org.optaplanner.core.api.domain.variable.CustomShadowVariable;
import org.optaplanner.core.api.domain.variable.InverseRelationShadowVariable;
import org.optaplanner.core.api.domain.variable.PlanningVariableReference;
import org.optaplannerdelirium.sss.domain.location.Location;

@PlanningEntity
public interface Standstill {

    Location getLocation();

    /**
     * @return sometimes null
     */
    Reindeer getReindeer();

    /**
     * @return sometimes null
     */
    @InverseRelationShadowVariable(sourceVariableName = "previousStandstill")
    GiftAssignment getNextGiftAssignment();
    void setNextGiftAssignment(GiftAssignment nextGiftAssignment);

    @CustomShadowVariable(variableListenerRef = @PlanningVariableReference(
            entityClass = GiftAssignment.class, variableName = "transportationWeight"))
    Long getTransportationToNextPenalty();
    void setTransportationToNextPenalty(Long transportationToNextPenalty);

    Long getTransportationWeight();

    double getDistanceToNextGiftAssignmentOrReindeer();
    double getDistanceTo(Standstill standstill);

}
