--リチュアに伝わりし禁断の秘術
--Forbc28429121den Arts of the Gishki
function c28429121.initial_effect(c)
	--Activate
	local e1=Ritual.CreateProc(c,RITPROC_EQUAL,aux.FilterBoolFunction(Card.IsSetCard,0x3a),nil,nil,c28429121.extrafil,c28429121.extraop,aux.FilterBoolFunction(Card.IsOnField))
	e1:SetCost(c28429121.cost)
	c:RegisterEffect(e1)
end
c28429121.listed_series={0x3a}
function c28429121.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCurrentPhase()~=PHASE_MAIN2 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_BP)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetTargetRange(1,0)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c28429121.mfilter(c,e)
	return c:IsFaceup() and c:GetLevel()>0 and not c:IsImmuneToEffect(e) and c:IsReleasable()
end
function c28429121.extrafil(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroup(c28429121.mfilter,tp,0,LOCATION_MZONE,nil,e)
end
function c28429121.extraop(mat,e,tp,eg,ep,ev,re,r,rp,sc)
	Duel.ReleaseRitualMaterial(mat)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK)
	e1:SetValue(sc:GetAttack()/2)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD)
	sc:RegisterEffect(e1)
end