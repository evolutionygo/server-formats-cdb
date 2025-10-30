local cm,m=GetID()
local list={120109057}
cm.name="救援兔"
function cm.initial_effect(c)
	RD.AddCodeList(c,list)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(m,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_GRAVE_SPSUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(cm.cost)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.operation)
	c:RegisterEffect(e1)
end
--Special Summon
function cm.spfilter(c,e,tp)
	return c:IsType(TYPE_NORMAL) and c:IsLevelBelow(4)
		and RD.IsCanBeSpecialSummoned(c,e,tp,POS_FACEUP)
end
function cm.check(g)
	return g:GetClassCount(Card.GetRace)==1
end
cm.cost=RD.CostSendSelfToDeckBottom()
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local mg=Duel.GetMatchingGroup(cm.spfilter,tp,LOCATION_GRAVE,0,nil,e,tp)
	if chk==0 then return Duel.GetMZoneCount(tp,e:GetHandler())>1
		and mg:CheckSubGroup(cm.check,2,2) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,tp,LOCATION_GRAVE)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	if RD.SelectGroupAndSpecialSummon(aux.NecroValleyFilter(cm.spfilter),cm.check,tp,LOCATION_GRAVE,0,2,2,nil,e,POS_FACEUP)~=0 then
		local g=Duel.GetOperatedGroup()
		g:ForEach(function(tc)
			RD.AttachEndPhase(e,tc,tp,m,cm.desop,aux.Stringid(m,1))
		end)
	end
	if Duel.GetFlagEffect(tp,m)~=0 then return end
	RD.CreateCannotActivateEffect(e,aux.Stringid(m,2),cm.aclimit,tp,1,0,RESET_PHASE+PHASE_END)
	Duel.RegisterFlagEffect(tp,m,RESET_PHASE+PHASE_END,0,1)
end
function cm.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,0,m)
	Duel.Destroy(e:GetLabelObject(),REASON_EFFECT)
end
function cm.aclimit(e,re,tp)
	local tc=re:GetHandler()
	return RD.IsLegendCode(tc,list[1])
end