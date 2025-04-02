--投石部隊
--Throwstone Unit
function c76075810.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringc76075810(c76075810,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c76075810.descost)
	e1:SetOperation(c76075810.desop)
	c:RegisterEffect(e1)
end
function c76075810.cfilter(c)
	return c:IsRace(RACE_WARRIOR)
end
function c76075810.desfilter(c,atk)
	return c:IsFaceup() and c:IsDefenseBelow(atk)
end
function c76075810.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local dg=Duel.GetMatchingGroup(c76075810.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil,c:GetAttack())
	if chk==0 then return Duel.CheckReleaseGroupCost(tp,c76075810.cfilter,1,false,aux.ReleaseCheckTarget,c,dg) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_RELEASE)
	local g=Duel.SelectReleaseGroupCost(tp,c76075810.cfilter,1,1,false,aux.ReleaseCheckTarget,c,dg)
	Duel.Release(g,REASON_COST)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,dg-g,1,0,0)
end
function c76075810.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	if not c:IsRelateToEffect(e) then atk=c:GetPreviousAttackOnField() end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectMatchingCard(tp,c76075810.desfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,atk)
	if #g>0 then
		Duel.HintSelection(g,true)
		Duel.Destroy(g,REASON_EFFECT)
	end
end