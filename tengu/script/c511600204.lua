--クロック・リザード
--Clock Lizard
--Scripted by Larry126
function c511600204.initial_effect(c)
	--link summon
	c:EnableReviveLimit()
	Link.AddProcedure(c,aux.FilterBoolFunctionEx(Card.IsRace,RACE_CYBERSE),2)
	--fusion summon
	local e1=Fusion.CreateSummonEff({handler=c,location=LOCATION_GRAVE,fusfilter=c511600204.lizardcheck,matfilter=aux.FALSE,
									extrafil=c511600204.extrafil,preselect=c511600204.preop,desc=aux.Stringc511600204(c511600204,0),
									extraop=Fusion.BanishMaterial,nosummoncheck=true,chkf=PLAYER_NONE})
	e1:SetCategory(CATEGORY_TOEXTRA+CATEGORY_SPECIAL_SUMMON+CATEGORY_FUSION_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCost(c511600204.spcost)
	e1:SetTarget((function(tg)
		return function(e,tp,eg,ep,ev,re,r,rp,chk)
			if chk==0 then
				return Duel.IsPlayerCanRemove(tp) and aux.CheckSummonGate(tp,2) and tg(e,tp,eg,ep,ev,re,r,rp,chk)
			end
			Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,nil,1,tp,LOCATION_GRAVE)
			Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
		end
	end)(e1:GetTarget()))
	c:RegisterEffect(e1)
	--atk down
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringc511600204(c511600204,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_REMOVE)
	e2:SetCondition(c511600204.atkcon)
	e2:SetOperation(c511600204.atkop)
	c:RegisterEffect(e2)
end
function c511600204.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsReleasable() end
	Duel.Release(e:GetHandler(),REASON_COST)
end
function c511600204.lizardcheck(c,tp)
	return c:IsAbleToExtra() and not c:IsHasEffect(CARD_CLOCK_LIZARD)
		and Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),{c:GetOriginalSetCard()},c:GetOriginalType(),c:GetBaseAttack(),c:GetBaseDefense(),c:GetOriginalLevel(),c:GetOriginalRace(),c:GetOriginalAttribute())
end
function c511600204.checkextra(c)
	return function(tp,sg,fc)
		return (fc:IsLocation(LOCATION_EXTRA) and Duel.GetLocationCountFromEx(tp,tp,sg,fc) or Duel.GetLocationCountFromEx(tp,tp,sg+c,TYPE_FUSION))>0
	end
end
function c511600204.extrafil(e,tp,mg)
	return Duel.GetMatchingGroup(Fusion.IsMonsterFilter(Card.IsAbleToRemove),tp,Duel.IsPlayerAffectedByEffect(tp,69832741) and LOCATION_MZONE or LOCATION_GRAVE,0,nil),c511600204.checkextra(e:GetHandler())
end
function c511600204.preop(e,tc)
	return Duel.SendtoDeck(tc,nil,2,REASON_EFFECT)~=0
end
function c511600204.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsPreviousLocation(LOCATION_GRAVE)
end
function c511600204.atkop(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTarget(c511600204.con)
	e1:SetOperation(c511600204.op)
	Duel.RegisterEffect(e1,tp)
end
function c511600204.filter(c,p)
	return c:IsControler(p) and c:HasNonZeroAttack()
end
function c511600204.con(e,tp,eg,ep,ev,re,r,rp,chk)
	return eg:IsExists(c511600204.filter,1,nil,1-tp)
end
function c511600204.op(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,tp,c511600204)
	Duel.Hint(HINT_CARD,1-tp,c511600204)
	local atk=Duel.GetMatchingGroupCount(Card.IsRace,tp,LOCATION_GRAVE,0,nil,RACE_CYBERSE)*400
	for tc in aux.Next(eg:Filter(c511600204.filter,nil,1-tp)) do
		local e1=Effect.CreateEffect(e:GetOwner())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-atk)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
	end
end