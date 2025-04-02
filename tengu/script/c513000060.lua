--Ｎｏ.３９ 希望皇ビヨンド・ザ・ホープ (Anime)
--Number 39: Utopia Beyond (Anime)
--Fixed and Cleaned By:TheOnePharaoh
Duel.LoadCardScript("c21521304.lua")
function c513000060.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,nil,6,2)
	c:EnableReviveLimit()
	--Rank Up Check
	aux.EnableCheckRankUp(c,nil,nil,84013237)
	--battle indestructable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(aux.NOT(aux.TargetBoolFunction(Card.IsSetCard,SET_NUMBER)))
	c:RegisterEffect(e1)
	--Immune
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_IMMUNE_EFFECT)
	e2:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_ONFIELD,0)
	e2:SetValue(c513000060.efilter)
	c:RegisterEffect(e2)
	--atk down
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_ATTACK_FINAL)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_MZONE)
	e3:SetCondition(c513000060.atkcon)
	e3:SetValue(0)
	--spsummon
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringc513000060(c513000060,0))
	e4:SetCategory(CATEGORY_REMOVE+CATEGORY_SPECIAL_SUMMON+CATEGORY_RECOVER)
	e4:SetType(EFFECT_TYPE_QUICK_O)
	e4:SetCode(EVENT_FREE_CHAIN)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCountLimit(1)
	e4:SetCondition(c513000060.spcon)
	e4:SetCost(aux.dxmcostgen(1,1,nil))
	e4:SetTarget(c513000060.sptg)
	e4:SetOperation(c513000060.spop)
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_RANKUP_EFFECT)
	e5:SetLabelObject(e3)
	c:RegisterEffect(e5)
	local e6=e5:Clone()
	e6:SetLabelObject(e4)
	c:RegisterEffect(e6,false,REGISTER_FLAG_DETACH_XMAT)
end
c513000060.listed_series={SET_NUMBER}
c513000060.listed_names={84013237}
c513000060.aux.xyz_number=39
function c513000060.efilter(e,re)
	return re:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
function c513000060.atkcon(e)
	return Duel.GetTurnPlayer()==e:GetHandlerPlayer() and Duel.IsBattlePhase()
end
function c513000060.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsBattlePhase()
end
function c513000060.rmfilter(c,e,tp,ft)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAbleToRemove() and (ft>0 or c:GetSequence()<5)
		and Duel.IsExistingMatchingCard(c513000060.spfilter,tp,LOCATION_GRAVE,0,1,nil,e,tp)
end
function c513000060.spfilter(c,e,tp)
	return c:IsCode(84013237) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c513000060.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>-1
		and Duel.IsExistingMatchingCard(c513000060.rmfilter,tp,LOCATION_MZONE,0,1,nil,e,tp,ft) end
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,1,tp,LOCATION_MZONE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,0,0,tp,0)
end
function c513000060.spop(e,tp,eg,ep,ev,re,r,rp)
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectMatchingCard(tp,c513000060.rmfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp,ft)
	if #g1>0 then
		Duel.HintSelection(g1)
		if Duel.Remove(g1,POS_FACEUP,REASON_EFFECT)==0 then return end
		Duel.BreakEffect()
		if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local g2=Duel.SelectMatchingCard(tp,c513000060.spfilter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		Duel.HintSelection(g2)
		if Duel.SpecialSummon(g2,0,tp,tp,false,false,POS_FACEUP)>0 then
			Duel.Recover(tp,g2:GetFirst():GetAttack()/2,REASON_EFFECT)
		end
	end
end